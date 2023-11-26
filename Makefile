install:
	bundle install

lint:
	rubocop

test:
	ruby -Ilib -Itest -r ./test/test_hexlet_code.rb -e 'ARGV.each { |f| require "./#{f}" }' $(TESTS)

.PHONY: test
