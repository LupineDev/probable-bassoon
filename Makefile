DC_RUN=docker compose run -u root --rm

bootstrap: reset

update:
	docker compose build
	docker compose stop
	$(DC_RUN) web bundle install -j 4
	docker compose build

run:
	$(DC_RUN) --service-ports web

bash:
	$(DC_RUN) web bash

bash_test:
	$(DC_RUN) -e RAILS_ENV=test web bash

rspec:
	$(DC_RUN) -e RAILS_ENV=test web bundle exec rspec

reset:
	docker compose stop
	docker compose down -v
	$(DC_RUN) web bundle install -j 4
	$(DC_RUN) web bin/rails db:setup