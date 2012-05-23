require 'net/http'

module Puppet::Parser::Functions
  newfunction(:vb_latest_dmg_url) do
    vb_latest_ver = Net::HTTP.get(URI 'http://download.virtualbox.org/virtualbox/LATEST.TXT')
    package_index = Net::HTTP.get(URI "http://download.virtualbox.org/virtualbox/#{vb_latest_ver}/")
    vb_latest_dmg = package_index[/VirtualBox-#{vb_latest_ver}.*?\.dmg/]

    "http://download.virtualbox.org/virtualbox/#{vb_latest_ver}/#{vb_latest_dmg}"
  end
end

node 'default' do
  projects_dir = "#{ENV['HOME']}/projects"

  file projects_dir,
    :ensure => :directory

  vcsrepo "#{projects_dir}/myrcs",
    :ensure   => :present,
    :source   => "https://github.com/artemave/myrcs.git",
    :provider => :git,
    :require  => "file[#{projects_dir}]"

  %w[tree htop].each do |pck|
    package pck,
      :ensure => :installed,
      :provider => :brew
  end

  package 'VirtualBox',
    :ensure => :present,
    :provider => :pkgdmg,
    :source => vb_latest_dmg_url

  # chrome
  # adium
  # virtualbox
  # spotify
  # skype
  # dropbox
  # evernote
  # sparrow
  # alfred
  # chicken of the vnc
  # colloquy
  # firefox
  # flux
  # cyberduck
  # growl
  # tinker tool
  #
  # brew %w[git hub tree ack]
  # postgres
  # mysql
  # zsh
  # mvim
  # rvm
  # tmux
  #
  # install rc files



end

