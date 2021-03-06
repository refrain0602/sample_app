namespace :db do

	desc "Fill database with sample data"
	
	task populate: :environment do
	
		make_users
		make_microposts
		make_relationships
	end
end

def make_users
	
	admin =	User.create!( name: "Example User",
						email: "example@railstutorial.com",
						password: "foobar",
						password_confirmation: "foobar",
						admin: true )
	
	99.times do | n |
	
		name = Faker::Name.name
		
		email = "example-#{n+1}@railstutorial.jp"
		
		password = "password"
		
		User.create!( name: name,
					email: email,
					password: password,
					password_confirmation: password )
	
	end
end

def make_microposts
	
	users = User.all( limit: 6 )
	
	50.times do
		content = Faker::Lorem.sentence( 5 )
		
		users.each { | user | user.microposts.create!( content: content ) }
	end
end

def make_relationships
	users = User.all
	user = users.first
	
	followed_users	= users[2..50]
	followers		= users[3..40]
	
	followed_users.each { | followed | user.follow!( followed ) }
	followers.each		{ | follower | follower.follow!( user ) }

end




unless ARGV.any? {|a| a =~ /^gems/} # Don't load anything when running the gems:* tasks

vendored_cucumber_bin = Dir["#{Rails.root}/vendor/{gems,plugins}/cucumber*/bin/cucumber"].first
$LOAD_PATH.unshift(File.dirname(vendored_cucumber_bin) + '/../lib') unless vendored_cucumber_bin.nil?

begin
  require 'cucumber/rake/task'

  namespace :cucumber do
    Cucumber::Rake::Task.new({:ok => 'test:prepare'}, 'Run features that should pass') do |t|
      t.binary = vendored_cucumber_bin # If nil, the gem's binary is used.
      t.fork = true # You may get faster startup if you set this to false
      t.profile = 'default'
    end

    Cucumber::Rake::Task.new({:wip => 'test:prepare'}, 'Run features that are being worked on') do |t|
      t.binary = vendored_cucumber_bin
      t.fork = true # You may get faster startup if you set this to false
      t.profile = 'wip'
    end

    Cucumber::Rake::Task.new({:rerun => 'test:prepare'}, 'Record failing features and run only them if any exist') do |t|
      t.binary = vendored_cucumber_bin
      t.fork = true # You may get faster startup if you set this to false
      t.profile = 'rerun'
    end

    desc 'Run all features'
    task :all => [:ok, :wip]

    task :statsetup do
      require 'rails/code_statistics'
      ::STATS_DIRECTORIES << %w(Cucumber\ features features) if File.exist?('features')
      ::CodeStatistics::TEST_TYPES << "Cucumber features" if File.exist?('features')
    end
  end
  desc 'Alias for cucumber:ok'
  task :cucumber => 'cucumber:ok'

  task :default => :cucumber

  task :features => :cucumber do
    STDERR.puts "*** The 'features' task is deprecated. See rake -T cucumber ***"
  end

  # In case we don't have the generic Rails test:prepare hook, append a no-op task that we can depend upon.
  task 'test:prepare' do
  end

  task :stats => 'cucumber:statsetup'
rescue LoadError
  desc 'cucumber rake task not available (cucumber not installed)'
  task :cucumber do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
  end
end

end
