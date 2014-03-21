class AddAntibullying < ActiveRecord::Migration
  def up
    Skill.all.each do |s|
        if s.offset >=2
            s.offset += 1
            s.save!
        end
    end
    ab = Skill.new(:name => "Anti-Bullying", :offset => 2 )
    ab.save!
  end
end
