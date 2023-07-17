describe ApplicationHelper do
  describe '#current_locale_icon' do
    delegate :current_locale_icon, to: :helper

    context 'when locale en' do
      let(:locale) { :en }

      it 'return ukraine icon' do
        expect(current_locale_icon(locale)).to eq('ukraine')
      end
    end

    context 'when locale uk' do
      let(:locale) { :uk }

      it 'return england icon' do
        expect(current_locale_icon(locale)).to eq('england')
      end
    end
  end
end
