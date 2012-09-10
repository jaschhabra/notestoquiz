task :t_deploy  do
  Rake::Task["spec"].invoke
  Rake::Task["deploy"].invoke
end
