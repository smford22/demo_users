#
# Cookbook Name:: demo_users
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
include_recipe 'chef-vault'

search(:users, "*:*").each do |user_data|

  secret = chef_vault_item("secrets", user_data['id'])

  user user_data['id'] do
    supports :manage_home => true
    password secret['password']
    comment user_data['comment']
    uid user_data['uid']
    gid user_data['gid'].to_i
    shell user_data['shell']
    action user_data['action'].to_sym
  end

  group user_data['id'] do
    members [ user_data['id'] ]
    gid user_data['uid']
    action user_data['action'].to_sym
  end

  if user_data['action'] == 'create'
    user_data['groups'].each do |g|
      group g do
        members [ user_data['id'] ]
        append true
      end
    end

    directory "#{user_data['home']}/.ssh" do
      owner user_data['id']
      group user_data['id']
      mode 0700
    end

    file "#{user_data['home']}/.ssh/id_rsa" do
      content secret['ssh-key']
      owner user_data['id']
      group user_data['id']
      mode 0600
    end
  end
end
