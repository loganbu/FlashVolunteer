class AddCommunityCause < ActiveRecord::Migration
  def change

    Skill.all.each do |s|
        if s.offset >=4
            s.offset += 1
            s.save!
        end
    end
    community = Skill.new(:name => "Community", :offset => 4 )
    community.save!
  end
end
