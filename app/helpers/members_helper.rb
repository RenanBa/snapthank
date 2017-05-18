module MembersHelper
  def select_member(donor)
    member_selector = donor.id
    all_members = Member.all.length
    while member_selector > all_members do
      member_selector -= all_members
    end
    return Member.find(member_selector) if member_selector <= all_members
  end
end
