FactoryBot.define do
  factory :printer do
    printer_code { 'PRINTER1' }
    firm { 'Creality' }
    model { 'Ender 3' }
    table_size { '220x220x250' }
    price_for_printer { 10_000.0 }
  end
end
