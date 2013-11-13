admin = Admin.create!(
  name: 'Vicente',
  surname: 'Cubells',
  email: 'vcubells@itesm.mx',
  password: '123456'  
)

p "User: #{admin.email} | Pwd: #{admin.password}"
