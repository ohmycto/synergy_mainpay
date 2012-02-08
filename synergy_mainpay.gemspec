Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'synergy_mainpay'
  s.version = '0.70.1'
  s.summary = 'Adds payment method for mainpay.ru'
  s.required_ruby_version = '>= 1.8.7'

  s.authors = 'Sergey Rezvanov (Service & Consulting)'
  s.email = 'service@secoint.ru'
  s.homepage = 'http://github.com/secoint/synergy_mainpay'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.require_paths = [ 'lib' ]
  s.requirements << 'none'

  s.add_dependency('spree_core', '>= 0.70.1')

end
