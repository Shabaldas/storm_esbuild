describe ApplicationHelper do
  describe '#locale_switcher' do
    delegate :locale_switcher, to: :helper

    context 'when current locale is en' do
      before { allow(I18n).to receive(:locale).and_return(:en) }

      it 'returns a button to change the locale to uk' do
        expect(locale_switcher(:uk, 'icons_svg/ukraine_flag.svg')).to have_button(
          type: 'submit',
          class: 'pt-1'
        )

        expect(locale_switcher(:uk, 'icons_svg/ukraine_flag.svg')).to have_css(
          'div.flex.w-6.h-6.p-0.justify-center.items-center'
        )
      end

      it 'returns a div element and en locale will be disabled' do
        expect(locale_switcher(:en, 'icons_svg/english_flag.svg')).to have_no_button(
          type: 'submit',
          class: 'pt-1'
        )

        expect(locale_switcher(:en, 'icons_svg/english_flag.svg')).to have_css(
          'div.flex.w-6.h-6.p-0.justify-center.items-center.cursor-not-allowed'
        )
      end
    end
  end

  describe '#order_status_icon' do
    delegate :order_status_icon, to: :helper

    let!(:manual_order) { create(:manual_order, status: :paid) }

    it 'returns done icon' do
      expect(order_status_icon(manual_order)).to eq('done_icon')
    end
  end
end
