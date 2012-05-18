
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
end
