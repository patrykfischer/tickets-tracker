class UserForm < Reform::Form
  properties :name,
             :email,
             validates:  { presence: true }

  def email=(email)
    super(email.downcase)
  end
end
