# Services
services = [
  ["Tune-up", 45.00],
  ["Brake bleed", 35.00],
  ["Chain replacement", 30.00],
  ["Flat tyre repair", 15.00],
  ["Gear adjustment", 20.00],
  ["Brake pad replacement", 25.00],
  ["Bottom bracket service", 40.00],
  ["Full service", 90.00],
  ["Tyre replacement", 20.00],
  ["Cable replacement", 18.00],
  ["Spoke replacement", 12.00],
  ["Suspension fork service", 60.00],
  ["Disc brake rotor truing", 15.00],
  ["Wheel truing", 25.00],
  ["Headset adjustment", 22.00],
  ["Cassette replacement", 35.00],
  ["Derailleur replacement", 50.00],
  ["Tubeless setup", 30.00],
  ["Brake inspection", 10.00],
  ["Safety inspection", 15.00]
]

service_items = {}

services.each do |name, price|
  service = ServiceItem.find_or_initialize_by(name: name)
  service.current_price = price
  service.save!
  service_items[name] = service
end

# Mechanics
mechanics = [
  Mechanic.find_or_create_by!(name: "Sofia Morales"),
  Mechanic.find_or_create_by!(name: "Daniel Rojas"),
  Mechanic.find_or_create_by!(name: "Camila Fuentes")
]

# Customers
customers = [
  ["Ana Pérez", "+56 9 5555 0101"],
  ["Bruno Castillo", "+56 9 5555 0102"],
  ["Carolina Soto", "+56 9 5555 0103"],
  ["Diego Muñoz", "+56 9 5555 0104"],
  ["Elena Vargas", "+56 9 5555 0105"],
  ["Felipe Torres", "+56 9 5555 0106"],
  ["Gabriela Reyes", "+56 9 5555 0107"],
  ["Hugo Navarro", "+56 9 5555 0108"],
  ["Isabel Contreras", "+56 9 5555 0109"],
  ["Javier Espinoza", "+56 9 5555 0110"],
  ["Karen Valdés", "+56 9 5555 0111"],
  ["Javiera Acuña", "+56 9 1234 5678"]
]

customer_records = {}

customers.each do |name, phone|
  customer = Customer.find_or_initialize_by(name: name)
  customer.phone = phone
  customer.save!
  customer_records[name] = customer
end

# Bikes
bikes = {}

bike_data = [
  ["Ana Pérez", "Trek Domane", "DOM-1001"],
  ["Ana Pérez", "Specialized Allez", "ALL-1002"],
  ["Bruno Castillo", "Giant Contend", "CON-1003"],
  ["Carolina Soto", "Trek Marlin", "MAR-1004"],
  ["Diego Muñoz", "Cannondale Trail", "TRA-1005"],
  ["Elena Vargas", "Scott Speedster", "SPD-1006"],
  ["Felipe Torres", "Giant Defy", "DEF-1007"],
  ["Gabriela Reyes", "Specialized Rockhopper", "ROC-1008"],
  ["Hugo Navarro", "Trek Marlin", "MAR-1009"],
  ["Isabel Contreras", "Cannondale Quick", "QUI-1010"],
  ["Javier Espinoza", "Giant Talon", "TAL-1011"],
  ["Karen Valdés", "Specialized Allez", "ALL-1012"],
  ["Javiera Acuña", "Terraneitor", "ENF-1234"]
]

bike_data.each do |customer_name, model, serial_number|
  bike = Bike.find_or_initialize_by(serial_number: serial_number)
  bike.customer_id = customer_records.fetch(customer_name).id
  bike.model = model
  bike.save!
  bikes[serial_number] = bike
end

today = Date.current

# Repairs
repairs = {}

repair_data = [
  {
    key: :diagnosis,
    bike: "DOM-1001",
    mechanic: mechanics[0],
    status: "in_diagnosis",
    decision: nil,
    promised_on: today + 2,
    dropped_off_at: today.beginning_of_day + 9.hours
  },
  {
    key: :approval,
    bike: "ALL-1002",
    mechanic: mechanics[1],
    status: "awaiting_decision",
    decision: nil,
    promised_on: today + 3,
    dropped_off_at: today.beginning_of_day + 10.hours
  },
  {
    key: :approved,
    bike: "CON-1003",
    mechanic: mechanics[2],
    status: "in_progress",
    decision: "approved",
    promised_on: today + 1,
    dropped_off_at: today.beginning_of_day - 1.day + 11.hours
  },
  {
    key: :ready,
    bike: "MAR-1004",
    mechanic: mechanics[0],
    status: "ready_for_pickup",
    decision: "approved",
    promised_on: today + 1,
    dropped_off_at: today.beginning_of_day - 2.days + 9.hours
  },
  {
    key: :collected,
    bike: "TRA-1005",
    mechanic: mechanics[1],
    status: "collected",
    decision: "approved",
    promised_on: today - 2.days,
    dropped_off_at: today.beginning_of_day - 4.days + 10.hours,
    collected_at: today.beginning_of_day - 1.day + 15.hours
  },
  {
    key: :same_day,
    bike: "SPD-1006",
    mechanic: mechanics[2],
    status: "collected",
    decision: "assumed_approved",
    promised_on: today,
    dropped_off_at: today.beginning_of_day + 8.hours,
    collected_at: today.beginning_of_day + 16.hours
  },
  {
    key: :overdue,
    bike: "DEF-1007",
    mechanic: mechanics[0],
    status: "in_progress",
    decision: "approved",
    promised_on: today - 3.days,
    dropped_off_at: today.beginning_of_day - 5.days + 9.hours
  },
  {
    key: :declined,
    bike: "ROC-1008",
    mechanic: mechanics[1],
    status: "ready_for_pickup",
    decision: "declined",
    promised_on: today - 1.day,
    dropped_off_at: today.beginning_of_day - 2.days + 13.hours
  },
  {
    key: :history_one,
    bike: "MAR-1009",
    mechanic: mechanics[2],
    status: "collected",
    decision: "approved",
    promised_on: today - 20.days,
    dropped_off_at: today.beginning_of_day - 25.days + 10.hours,
    collected_at: today.beginning_of_day - 19.days + 16.hours
  },
  {
    key: :history_two,
    bike: "MAR-1009",
    mechanic: mechanics[0],
    status: "ready_for_pickup",
    decision: "approved",
    promised_on: today - 2.days,
    dropped_off_at: today.beginning_of_day - 5.days + 10.hours
  },
  {
    key: :historical,
    bike: "QUI-1010",
    mechanic: mechanics[1],
    status: "collected",
    decision: "approved",
    promised_on: Date.new(2025, 12, 20),
    dropped_off_at: Date.new(2025, 12, 18).to_time.change(hour: 9),
    collected_at: Date.new(2025, 12, 19).to_time.change(hour: 16)
  },
  {
    key: :fresh,
    bike: "TAL-1011",
    mechanic: mechanics[2],
    status: "dropped_off",
    decision: nil,
    promised_on: today + 4,
    dropped_off_at: today.beginning_of_day + 12.hours
  },
  {
    key: :extra_one,
    bike: "ALL-1012",
    mechanic: mechanics[0],
    status: "in_diagnosis",
    decision: nil,
    promised_on: today + 5,
    dropped_off_at: today.beginning_of_day + 9.hours
  },
  {
    key: :extra_two,
    bike: "DOM-1001",
    mechanic: mechanics[1],
    status: "ready_for_pickup",
    decision: "approved",
    promised_on: today + 1,
    dropped_off_at: today.beginning_of_day - 1.day + 10.hours
  },
  {
    key: :extra_three,
    bike: "CON-1003",
    mechanic: mechanics[2],
    status: "collected",
    decision: "declined",
    promised_on: today - 6.days,
    dropped_off_at: today.beginning_of_day - 8.days + 11.hours,
    collected_at: today.beginning_of_day - 6.days + 14.hours
  }
]

repair_data.each do |data|
  repair = Repair.find_or_initialize_by(
    bike_id: bikes.fetch(data[:bike]).id,
    dropped_off_at: data[:dropped_off_at]
  )

  repair.mechanic_id = data[:mechanic]&.id
  repair.status = data[:status]
  repair.decision = data[:decision]
  repair.promised_on = data[:promised_on]
  repair.collected_at = data[:collected_at]
  repair.save!

  repairs[data[:key]] = repair
end

# Repair line items
line_items = {
  diagnosis: [
    ["Tune-up", 45.00],
    ["Brake inspection", 10.00]
  ],
  approval: [
    ["Full service", 90.00]
  ],
  approved: [
    ["Brake pad replacement", 25.00],
    ["Gear adjustment", 20.00]
  ],
  ready: [
    ["Chain replacement", 30.00],
    ["Cable replacement", 18.00]
  ],
  collected: [
    ["Tyre replacement", 20.00]
  ],
  same_day: [
    ["Flat tyre repair", 15.00]
  ],
  overdue: [
    ["Full service", 90.00],
    ["Wheel truing", 20.00]
  ],
  declined: [
    ["Suspension fork service", 60.00]
  ],
  history_one: [
    ["Brake bleed", 35.00]
  ],
  history_two: [
    ["Gear adjustment", 20.00],
    ["Cable replacement", 18.00]
  ],
  historical: [
    ["Full service", 75.00],
    ["Brake pad replacement", 20.00]
  ],
  fresh: [
    ["Safety inspection", 15.00]
  ],
  extra_one: [
    ["Headset adjustment", 22.00]
  ],
  extra_two: [
    ["Spoke replacement", 12.00],
    ["Disc brake rotor truing", 15.00]
  ],
  extra_three: [
    ["Brake inspection", 8.00]
  ]
}

line_items.each do |repair_key, items|
  repair = repairs.fetch(repair_key)

  items.each do |service_name, price|
    service_item = service_items.fetch(service_name)

    line_item = RepairLineItem.find_or_initialize_by(
      repair_id: repair.id,
      service_item_id: service_item.id
    )

    line_item.price_charged = price
    line_item.save!
  end
end

# Intake photos
photo_files = %w[bike_1.jpg bike_2.jpg bike_3.jpg bike_4.jpg bike_5.jpg].map do |filename|
  { filename: filename, path: Rails.root.join("db/seeds/photos", filename) }
end

photo_assignments = {
  diagnosis: [photo_files[0]],
  approval: [photo_files[1], photo_files[2]],
  approved: [photo_files[0], photo_files[3]],
  ready: [photo_files[2]],
  collected: [photo_files[1]],
  overdue: [photo_files[0], photo_files[1], photo_files[2], photo_files[4]], # 4+ photos
  declined: [photo_files[3]],
  history_one: [photo_files[4]],
  history_two: [photo_files[0], photo_files[2]],
  historical: [photo_files[1]]
  # fresh, extra_one, extra_two, extra_three: intentionally no photos (covers "at least two have none")
}

photo_assignments.each do |repair_key, files|
  repair = repairs.fetch(repair_key)
  next if repair.photos.attached?

  files.each do |file|
    repair.photos.attach(
      io: File.open(file[:path]),
      filename: file[:filename],
      content_type: Marcel::MimeType.for(File.open(file[:path]))
    )
  end
end

# Diagnoses, with real formatting
diagnosis_text = {
  diagnosis: "<p>Initial inspection complete.</p><p><strong>Findings:</strong></p><ul><li>Worn brake pads</li><li>Chain stretch beyond spec</li><li>Derailleur hanger slightly bent</li></ul>",
  approval: "<p><strong>Quote prepared</strong> for customer review.</p><ul><li>Full service recommended</li><li>Estimated 2 hours of labor</li></ul>",
  approved: "<p>Customer <strong>approved</strong> the quoted work.</p><ul><li>Brake pads replaced</li><li>Gears adjusted and tested</li></ul>",
  ready: "<p>Repair complete. <strong>Ready for pickup.</strong></p><ul><li>New chain installed</li><li>Cables replaced</li></ul>",
  collected: "<p>Tyre replaced successfully. <strong>No further issues found.</strong></p>",
  overdue: "<p><strong>Extensive repair in progress.</strong></p><ul><li>Full service underway</li><li>Wheel truing completed</li><li>Awaiting replacement part for final adjustment</li></ul>",
  declined: "<p>Customer <strong>declined</strong> the suspension service after reviewing cost.</p><ul><li>Fork inspected</li><li>Minor oil seep noted, not urgent</li></ul>",
  history_one: "<p>Routine <strong>brake bleed</strong> performed, no complications.</p>",
  history_two: "<p>Gear and cable service completed.</p><ul><li>Rear derailleur indexed</li><li>Cables lubricated</li></ul>",
  historical: "<p><strong>Full service</strong> completed ahead of long-term storage.</p><ul><li>Drivetrain degreased</li><li>Brakes inspected and adjusted</li></ul>"
  # fresh, extra_one, extra_two, extra_three: intentionally blank — freshly dropped-off repairs have no diagnosis yet
}

diagnosis_text.each do |repair_key, html|
  repair = repairs.fetch(repair_key)
  repair.update!(diagnosis: html) if repair.diagnosis.blank?
end