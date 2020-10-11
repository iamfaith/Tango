setup-configs: 
	echo "Creating default Autolab/config/database.yml"
	cp -n ./Autolab/config/database.docker.yml ./Autolab/config/database.yml

	echo "Creating default Autolab/config/school.yml"
	cp -n ./Autolab/config/school.yml.template ./Autolab/config/school.yml

	echo "Creating default Autolab/config/initializers/devise.rb"
	cp -n ./Autolab/config/initializers/devise.rb.template ./Autolab/config/initializers/devise.rb

	# Replace the Devise secret key with a random string
	echo "Setting random Devise secret"
	sed -i.bak "s/<YOUR-SECRET-KEY>/`LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c 128`/g" ./Autolab/config/initializers/devise.rb && rm ./Autolab/config/initializers/devise.rb.bak

	echo "Creating default Autolab/config/environments/production.rb"
	cp -n ./Autolab/config/environments/production.rb.template ./Autolab/config/environments/production.rb

	echo "Creating default Autolab/config/autogradeConfig.rb"
	cp -n ./Autolab/config/autogradeConfig.rb.template ./Autolab/config/autogradeConfig.rb

db-migrate:
	docker exec -it autolab bash /home/app/webapp/docker/db_migrate.sh

update:
	cd ./Autolab && git checkout master && git pull origin master
	cd ..
	cd ./Tango && git checkout master && git pull origin master
	cd ..

	
clean:
	rm -r ./Autolab/config/database.yml
	rm -r ./Autolab/config/school.yml
	rm -r ./Autolab/config/initializers/devise.rb
	rm -r ./Autolab/config/environments/production.rb
	rm -r ./Autolab/config/autogradeConfig.rb