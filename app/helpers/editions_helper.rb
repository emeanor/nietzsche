module EditionsHelper

  def title_and_subtitle_string(edition)
    edition.has_subtitle? ? "#{edition.title}: #{edition.subtitle}" : edition.title
  end

end