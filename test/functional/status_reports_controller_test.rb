require 'test_helper'


class StatusReportsControllerTest < ActionController::TestCase
  setup do
    @status_report = status_reports(:one)
    login_as_one
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:status_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create status_report" do
    assert_difference('StatusReport.count') do
      post :create, status_report: { status_date: @status_report.status_date, today: @status_report.today, yesterday: @status_report.yesterday }
    end

    assert_redirected_to status_report_path(assigns(:status_report))
  end

  test "should show status_report" do
    get :show, id: @status_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @status_report
    assert_response :success
  end

  test "should update status_report" do
    put :update, id: @status_report, status_report: { status_date: @status_report.status_date, today: @status_report.today, yesterday: @status_report.yesterday }
    assert_redirected_to status_report_path(assigns(:status_report))
  end

  test "should destroy status_report" do
    assert_difference('StatusReport.count', -1) do
      delete :destroy, id: @status_report
    end

    assert_redirected_to status_reports_path
  end

	test "creation of status reports with data" do
		assert_difference('StatusReport.count', 1) do
			post :create, :status_report => {
				:yesterday => "I did stuff",
				:today => "I'll do stuff"}
		end
		actual = assigns(:status_report)
		assert_equal(users(:one).id, actual.user.id)
		assert_equal(Date.today.to_s(:db), actual.status_date.to_s(:db))
		assert_redirected_to status_report_path(actual)
	end

	test "redirect and logout if the user tries to snipe a user id" do 
		noel = User.create!(:email => "railsprescriptions@gmail.com", :password => "banana77", :password_confirmation => "banana77")
		set_current_project(:one)
		assert_no_difference('StatusReport.count') do 
			post :create, :status_report => {
				:user_id => noel.id,
				:yesterday => "I did stuff",
				:today => "I'll do stuff"}
		end
		assert_nil session[:user_id]
		assert_redirected_to(new_user_session_path)
	end
end
