install:
	bundle install

lint:
	rubocop

test:
	ruby -Ilib -Itest -r ./test/test_helper.rb -e 'ARGV.each { |f| require "./#{f}" }' $(TESTS)
