namespace :db do
	task :cycle do
		system 'rake db:drop'
		system 'rake db:create'
		system 'rake db:migrate'
		system 'rake db:seed'
	end
end
