require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "guest is redirected to login" do
    get projects_path
    assert_response :redirect
  end

  test "user can view own project" do
    sign_in_as users(:one)
    get projects_path(projects(:one))
    assert_response :success
  end

  test "user cannot view another user's project" do
    sign_in_as users(:one)
    get projects_path(projects(:two))
    assert_response :not_found
  end

  test "user can create project" do
    sign_in_as users(:one)
    assert_difference "Project.count", 1 do
      post projects_path, params: {
        project: {
          name: "New project",
          description: "Description"
        }
      }
    end

    assert_redirected_to projects_path(Project.last)
    assert_equal users(:one), Project.last.user
  end
end

