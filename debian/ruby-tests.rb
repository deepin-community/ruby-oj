ENV['TZ']="Europe/Paris"
SKIPPED_TESTS = [
  './test/./test_serializer.rb',
  './test/isolated/test_mimic_rails_before.rb',
  './test/isolated/test_mimic_rails_after.rb',
  './test/./test_bigd.rb',
  './test/isolated/test_mimic_rails_datetime.rb',
]

success=true
#Dir.glob("./test/{isolated,.}/test*.rb").each do |f|
["tests", "tests_mimic", "tests_mimic_addition"].map {|s| "test/#{s}.rb"}.each do |f|
  # we'd like to not have rails in Build-Depends, but this means we can't test the rails integration.
  next if SKIPPED_TESTS.include?(f)
  puts "-------- running #{f} test ------- "
  #system("TZ='Europe/Paris' #{ENV['RUBY_TEST_BIN']} -I#{ENV['RUBYLIB']} #{f}") or success=false
  system("#{ENV['RUBY_TEST_BIN']} -I#{ENV['RUBYLIB']} #{f}") or begin
    puts "E: Test #{f} has failed."
    success=false
  end
end

exit(1) unless(success)
