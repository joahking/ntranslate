class MenuTabBuilder < TabsOnRails::Tabs::TabsBuilder
  def tab_for(tab, name, options, item_options = {})
    item_options[:class] = item_options[:class].to_s.split(" ").push("current").join(" ") if current_tab?(tab)
    @context.content_tag(:li, item_options) do
      @context.link_to(name, options)
    end
  end
end
