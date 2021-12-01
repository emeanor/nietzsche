require 'json'

desc 'import texts from public/texts.json'
task import_texts: :environment do
  Text.delete_all

  texts = JSON.parse(File.read('public/texts.json'))
  texts.each do |text|
    Text.create(text)
    puts "Created text ##{text['nietzsche_number']}."
  end
end