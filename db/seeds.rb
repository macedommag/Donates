# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Criação de instituições de exemplo
Institution.create(name: 'Hospital São Lucas', cnpj: '12.345.678/0001-90', bank_account: '12345-6/789')

Institution.create(name: 'Orfanato Esperança', cnpj: '98.765.432/0001-21', bank_account: '98765-4/321')

Institution.create(name: 'Associação de Proteção Animal', cnpj: '54.321.098/0001-76', bank_account: '54321-0/987')

puts 'Instituições criadas com sucesso!'
