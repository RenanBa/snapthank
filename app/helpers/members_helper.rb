module MembersHelper
  def select_member(donor)
    member_selector = donor.id
    all_members = Member.all
    while member_selector > all_members.length do
      member_selector -= all_members.length
    end
    return Member.find_by_id(all_members[member_selector -1].id)
  end
end
