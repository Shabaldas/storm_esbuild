describe LocalesController do
  describe 'PUT /update' do
    context 'when default locale (en)' do
      let(:locale) { :uk }

      it 'sets locale to uk' do
        put :update, params: { locale: }
        expect(I18n.locale).to eq(locale)
      end
    end

    context 'when locale is uk' do
      let(:locale) { :en }

      it 'sets locale to en' do
        put :update, params: { locale: }
        expect(I18n.locale).to eq(locale)
      end
    end
  end
end
