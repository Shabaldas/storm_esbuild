describe PrintModelsController do
  describe 'GET/new' do
    it 'assigns a new print_model to @print_model and builds a new print_model_attribute' do
      get :new

      expect(assigns(:print_model)).to be_a_new(PrintModel)
      expect(assigns(:print_model).print_model_attributes.first).to be_a_new(PrintModelAttribute)
    end
  end
end
