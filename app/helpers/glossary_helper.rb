require 'glossary_import_info'

module GlossaryHelper
  def label_param(prmname)
    case prmname
    when 'id'
      '#'
    when 'project'
      l(:label_project)
    when 'category'
      l(:field_category)
    when 'datetime'
      l(:field_updated_on)
    when 'author'
      l(:field_author)
    when 'updater'
      l(:label_updater)
    when 'created_on'
      l(:field_created_on)
    when 'updated_on'
      l(:field_updated_on)
    when 'description'
      l(:field_description)
    else
      l("label.#{prmname}")
    end
  end

  def param_visible?(prmname)
    !Setting.plugin_redmine_glossary["hide_item_#{prmname}"]
  end

  def collect_visible_params(_prmary)
    ary = []
    prmary do |prm|
      ary << prm  if param_visible?(prm)
    end
  end

  def default_show_params
    Term.default_show_params
  end

  def default_searched_params
    Term.default_searched_params
  end

  def default_sort_params
    Term.default_sort_params
  end

  def params_select(form, name, prms)
    options = prms.collect { |prm| [label_param(prm), prm] }
    form.select(name, options, include_blank: true)
  end

  def params_select_tag(name, prms, defaultprm)
    options = ['']
    options += prms.collect { |prm| [label_param(prm), prm] }
    select_tag(name, options_from_collection_for_select(options), defaultprm)
  end

  # extract tokens from the question
  # eg. hello "bye bye" => ["hello", "bye bye"]
  def tokenize_by_space(str)
    str.scan(/((\s|^)"[\s\w]+"(\s|$)|\S+)/).collect do |m|
      m.first.gsub(/(^\s*"\s*|\s*"\s*$)/, '')
    end
  end

  def updated_by(updated, author)
    l(:label_updated_time_by, author: link_to_user(author), age: time_tag(updated)).html_safe
  end
end
