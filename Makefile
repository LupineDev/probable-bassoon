DC_RUN=docker compose run -u root --rm

update:
	docker compose build
	docker compose stop
	$(DC_RUN) web bundle install -j 4
	docker compose build

bash:
	$(DC_RUN) web bash

bash_test:
	$(DC_RUN) -e RAILS_ENV=test web bash

run:
	$(DC_RUN) --service-ports web

reset:
	docker compose stop
	docker compose down -v