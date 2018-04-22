require 'test_helper'

class MemberBalanceTest < ActionDispatch::IntegrationTest
  def setup
    @badminton_admin = users(:michael)
    @badminton_user = users(:lana)
    @badminton_member = members(:badminton_member_lana)

    @badminton = clubs(:badminton)
    @basketball = clubs(:basketball)
    @clubs_num = Club.count
    @hockey = clubs(:hockey)
    @other_user = users(:archer)
    @first_basketball = activities(:first_basketball)
  end

  test "a club admin can recharge a member's balance" do
    log_in_as(@badminton_admin)
    get user_path(@badminton_admin)
    assert_template 'users/show'
    assert_select 'a', text: @badminton.name, count: 1

    get club_path(@badminton)
    assert_select 'a[href=?]', members_club_path(@badminton)
    get members_club_path(@badminton)

    recharge_amount = 20
    assert_select 'table.club_members' do
      assert_select 'td', text: @badminton_user.name
      assert_difference 'Payment.count', 1 do
        post pay_club_path(@badminton), params: {payment: {member_id: @badminton_member.id, amount: recharge_amount}}
      end
    end

    assert_redirected_to members_club_path(@badminton)
    follow_redirect!
    new_balance = @badminton_member.balance + recharge_amount
    assert_select "td#balance-#{@badminton_member.id}", text: "#{new_balance}"

    # Make sure the new balance is shown up on use profile page
    get user_path(@badminton_user)
    assert_select "td#balance-#{@badminton_member.id}", text: "#{new_balance}"
  end
end
