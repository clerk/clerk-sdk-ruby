.PHONY: test

###########################
# Speakeasy
###########################

generate:
	speakeasy run

generate-log:
	@make generate >> log.txt 2>&1

###########################
# Internal
###########################

bundle:
	@cd apps/rails-api && bundle install
	@cd apps/rails-full && bundle install
	@bundle install

lint:
	rake rubocop

lint-fix:
	rake rubocop:autocorrect

# Usage: make test [file_path]
# Example: make test test/some_file.rb
test:
	@if [ -z "$$CLERK_SECRET_KEY" ]; then echo "CLERK_SECRET_KEY is not set"; exit 1; fi; \
	if [ -z "$$EMAIL_ADDRESS_ID" ]; then echo "EMAIL_ADDRESS_ID is not set"; exit 1; fi; \
	MT_NO_PLUGINS=1 rake test $(filter-out $@,$(MAKECMDGOALS)) --verbose

# Prevent Make from trying to build targets that match file names
%:
	@:

###########################
# Applications
###########################

rails:
	@cd apps/rails-full && bin/rails server

rails-api:
	@cd apps/rails-api && bin/rails server

rack:
	rerun --dir lib,apps/rack --pattern '**/*.{rb,ru}' -- bundle exec puma apps/rack/config.ru -p 3000

sinatra:
	rerun --dir lib,apps/sinatra --pattern '**/*.{erb,rb,ru}' -- bundle exec puma apps/sinatra/config.ru -p 3000 -v
