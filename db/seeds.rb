user = User.find_or_create_by!(email_address: "demo@example.com") do |record|
  record.name = "Demo User"
  record.password = "password123"
  record.password_confirmation = "password123"
end

project = user.projects.find_or_create_by!(name: "Học Ruby on Rails") do |record|
  record.description = "Dự án thực hành Rails từ cơ bản đến production."
end

[
  {
    title: "Học routing",
    status: :done,
    due_on: Date.current
  },
  {
    title: "Học Active Record",
    status: :in_progress,
    due_on: 2.days.from_now.to_date
  },
  {
    title: "Viết test",
    status: :todo,
    due_on: 5.days.from_now.to_date
  }
].each do |attributes|
  project.tasks.find_or_create_by!(title: attributes[:title]) do |task|
    task.assign_attributes(attributes)
  end
end