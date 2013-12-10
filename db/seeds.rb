admin = Admin.create!(
  name: 'Vicente',
  surname: 'Cubells',
  email: 'vcubells@itesm.mx',
  password: '123456'  
)

%w(App Libro Liga).each do |type|
  ReferenceType.create!(name: type)
end

p "User: #{admin.email} | Pwd: #{admin.password}"
