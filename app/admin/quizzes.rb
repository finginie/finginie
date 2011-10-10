ActiveAdmin.register Quiz do
 form do |f|
    f.inputs do
      f.input :name
      f.input :weight
    end

    f.has_many :questions do |q|
      q.inputs do
        q.input :text, :label => "Question"
        q.input :weight
      end

      q.has_many :choices do |c|
        c.input :text, :as => :string, :label => "Choice"
        c.input :score
        c.input :ceiling
      end
    end

    f.buttons
  end
end
