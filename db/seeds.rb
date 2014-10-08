# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

FrequentWord.create :name => 'a'

FrequentWord.create :name => 'az'


FrequentWord.create :name => 'és'

FrequentWord.create :name => 'vagy'

FrequentWord.create :name => 'and'
FrequentWord.create :name => 'in'
FrequentWord.create :name => 'to'
FrequentWord.create :name => 'or'
FrequentWord.create :name => 'the'
FrequentWord.create :name => 'for'




User.create name: 'miki', email_address: 'miklos.beky@gmail.com', password: 'aaaaaaaa9', password_confirmation: 'aaaaaaaa9'