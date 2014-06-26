# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140403194539) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "app_sync_reports", :force => true do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.string   "subtitle"
    t.integer  "standard_environment_id"
    t.integer  "target_environment_id"
    t.text     "header"
    t.text     "body"
    t.text     "footer"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.boolean  "trigger_refresh"
  end

  create_table "application_sync_jobs", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "applications", :force => true do |t|
    t.string   "name"
    t.string   "version"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.boolean  "check_reo_for_approval", :default => true
  end

  create_table "appropriate_roles_applications", :force => true do |t|
    t.integer  "role_id"
    t.integer  "application_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "approved_builds", :force => true do |t|
    t.string   "application_name"
    t.string   "build_number"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "auth_keys", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.integer  "created_by"
    t.string   "authorized_host_ip"
    t.boolean  "active"
    t.string   "seed"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "salt"
  end

  create_table "auto_approval_lists", :force => true do |t|
    t.integer  "system_configuration_id"
    t.integer  "environment_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "batch_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "checkout_result_details", :force => true do |t|
    t.string   "name"
    t.text     "result"
    t.integer  "checkout_result_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "checkout_results", :force => true do |t|
    t.string   "name"
    t.datetime "last_run_at"
    t.integer  "server_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "chores", :force => true do |t|
    t.string   "name"
    t.string   "command"
    t.string   "success"
    t.string   "fail"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "deployable_environment_lists", :force => true do |t|
    t.integer  "environment_id"
    t.integer  "system_configuration_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "deployment_plans", :force => true do |t|
    t.string   "name"
    t.integer  "application_id"
    t.integer  "mail_recipient_id"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.boolean  "run_pre_checkout",                 :default => true
    t.boolean  "run_post_checkout",                :default => true
    t.integer  "auto_promote_stop_environment_id"
    t.integer  "stop_auto_promote_environment_id"
    t.boolean  "use_oos_for_deployments"
    t.string   "oos_percentage"
    t.integer  "bleedoff_seconds"
    t.boolean  "use_batch_group_for_oos",          :default => true
  end

  add_index "deployment_plans", ["application_id"], :name => "index_deployment_plans_on_application_id"
  add_index "deployment_plans", ["mail_recipient_id"], :name => "index_deployment_plans_on_mail_recipient_id"

  create_table "deployment_requests", :force => true do |t|
    t.string   "package"
    t.string   "build"
    t.string   "environment"
    t.string   "auth_key"
    t.integer  "timing_delay"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "workflow_state"
    t.integer  "application_id"
  end

  create_table "deployment_set_environment_lists", :force => true do |t|
    t.integer  "deployment_set_id"
    t.integer  "environment_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "deployment_set_role_lists", :force => true do |t|
    t.integer  "deployment_set_id"
    t.integer  "role_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "deployment_sets", :force => true do |t|
    t.integer  "application_id"
    t.string   "build_number"
    t.boolean  "run_pre_checkout"
    t.boolean  "run_post_checkout"
    t.text     "changelist"
    t.boolean  "auto_accept"
    t.boolean  "auto_start"
    t.integer  "created_by"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "mail_recipient_id"
    t.integer  "deployment_set_id"
  end

  create_table "deployment_timings", :force => true do |t|
    t.integer  "deployment_id"
    t.string   "state"
    t.string   "event"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "deployment_timings", ["deployment_id"], :name => "index_deployment_timings_on_deployment_id"

  create_table "deployments", :force => true do |t|
    t.boolean  "latest"
    t.string   "build_number"
    t.integer  "environment_id"
    t.integer  "role_id"
    t.string   "to_release_at"
    t.integer  "accepted_by"
    t.integer  "completed_by"
    t.integer  "rejected_by"
    t.datetime "accepted_at"
    t.datetime "completed_at"
    t.datetime "rejected_at"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.text     "rejection_reason"
    t.integer  "mail_recipient_id"
    t.text     "changelist"
    t.string   "workflow_state"
    t.integer  "application_id"
    t.integer  "approved_by"
    t.datetime "approved_at"
    t.datetime "started_at"
    t.integer  "started_by"
    t.boolean  "in_retry"
    t.datetime "terminated_at"
    t.integer  "terminated_by"
    t.boolean  "terminated",              :default => false
    t.integer  "created_by"
    t.string   "rollback_build_number"
    t.boolean  "run_pre_checkout"
    t.boolean  "run_post_checkout"
    t.text     "pre_checkout"
    t.text     "post_checkout"
    t.string   "disc_space"
    t.integer  "deployment_set_id"
    t.boolean  "auto_accept",             :default => true
    t.boolean  "auto_start",              :default => true
    t.boolean  "skip_diskspace_check"
    t.boolean  "auto_promote"
    t.integer  "deployment_request_id"
    t.string   "batch"
    t.integer  "batch_group_id"
    t.string   "reason"
    t.boolean  "devsvcs_help_email_sent"
  end

  create_table "environment_sync_reports", :force => true do |t|
    t.integer  "trusted_environment_id"
    t.integer  "target_environment_id"
    t.integer  "work_to_perform_id"
    t.string   "workflow_state"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.boolean  "in_retry"
    t.datetime "started_at"
    t.integer  "started_by"
  end

  create_table "environments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "next_environment_id"
    t.boolean  "requires_reason"
    t.boolean  "tcs_environment"
  end

  add_index "environments", ["next_environment_id"], :name => "index_environments_on_next_environment_id"

  create_table "esr_package_problems", :force => true do |t|
    t.integer  "environment_sync_report_id"
    t.integer  "package_id"
    t.string   "conflict"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "trusted_version"
    t.string   "target_version"
  end

  create_table "esr_works", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "flow_parts", :force => true do |t|
    t.string   "name"
    t.integer  "chore_id"
    t.integer  "next_flow_part_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "flow_parts", ["chore_id"], :name => "index_flow_parts_on_chore_id"
  add_index "flow_parts", ["next_flow_part_id"], :name => "index_flow_parts_on_next_flow_part_id"

  create_table "flows", :force => true do |t|
    t.string   "name"
    t.integer  "environment_id"
    t.integer  "role_id"
    t.integer  "application_id"
    t.string   "build_number"
    t.boolean  "latest"
    t.text     "reason"
    t.integer  "first_flow_part_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "flows", ["application_id"], :name => "index_flows_on_application_id"
  add_index "flows", ["environment_id"], :name => "index_flows_on_environment_id"
  add_index "flows", ["first_flow_part_id"], :name => "index_flows_on_first_flow_part_id"
  add_index "flows", ["role_id"], :name => "index_flows_on_role_id"

  create_table "group_lists", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.boolean  "admin"
    t.boolean  "active"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.boolean  "manages_users"
    t.boolean  "manages_system"
    t.boolean  "manages_database"
    t.boolean  "manages_threads"
    t.boolean  "creates_deployments"
    t.boolean  "creates_switches"
    t.boolean  "executes_deployments"
    t.boolean  "executes_switches"
    t.boolean  "approves"
    t.boolean  "creates_reports"
    t.boolean  "views_reports"
    t.boolean  "refreshes_tripcase"
  end

  create_table "icons", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "jump_page_links", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "application_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "latest_releases", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "package"
    t.string   "version"
  end

  create_table "mail_recipients", :force => true do |t|
    t.string   "name"
    t.text     "addresses"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "oos_environment_lists", :force => true do |t|
    t.integer  "environment_id"
    t.integer  "deployment_plan_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "refreshes", :force => true do |t|
    t.string   "workflow_state"
    t.integer  "created_by"
    t.integer  "environment_id"
    t.integer  "role_id"
    t.text     "changelist"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.datetime "completed_at"
    t.boolean  "in_retry"
    t.datetime "terminated_at"
    t.boolean  "terminated"
  end

  add_index "refreshes", ["environment_id"], :name => "index_refreshes_on_environment_id"
  add_index "refreshes", ["role_id"], :name => "index_refreshes_on_role_id"

  create_table "reload_requests", :force => true do |t|
    t.boolean  "latest"
    t.integer  "build_number"
    t.integer  "environment_id"
    t.string   "package"
    t.integer  "role_id"
    t.string   "to_release_at"
    t.text     "email_notification_list"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "accepted_by"
    t.string   "completed_by"
    t.datetime "accepted_at"
    t.datetime "completed_at"
    t.datetime "rejected_at"
    t.string   "rejected_by"
  end

  add_index "reload_requests", ["environment_id"], :name => "index_reload_requests_on_environment_id"
  add_index "reload_requests", ["role_id"], :name => "index_reload_requests_on_role_id"

  create_table "retries", :force => true do |t|
    t.string   "workflow_state"
    t.integer  "deployment_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.text     "reason"
  end

  add_index "retries", ["deployment_id"], :name => "index_retries_on_deployment_id"

  create_table "role_sync_jobs", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "tcs_role"
  end

  create_table "run_logs", :force => true do |t|
    t.text     "log"
    t.string   "type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "agent_id"
  end

  add_index "run_logs", ["agent_id"], :name => "index_run_logs_on_agent_id"

  create_table "servers", :force => true do |t|
    t.string   "name"
    t.integer  "role_id"
    t.string   "runtime_env"
    t.integer  "environment_id"
    t.string   "classes"
    t.text     "switches"
    t.string   "sub_runtime_env"
    t.string   "batch_group"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "inactive"
  end

  create_table "suggestions", :force => true do |t|
    t.string   "name"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "switches", :force => true do |t|
    t.string   "name"
    t.boolean  "latest"
    t.integer  "build_number"
    t.integer  "environment_id"
    t.string   "role_id"
    t.integer  "accepted_by"
    t.integer  "completed_by"
    t.datetime "accepted_at"
    t.datetime "completed_at"
    t.datetime "rejected_at"
    t.integer  "rejected_by"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.integer  "mail_recipient_id"
    t.string   "workflow_state"
    t.integer  "started_by"
    t.datetime "started_at"
    t.boolean  "in_retry"
    t.boolean  "deploy_to_first_server_only"
    t.string   "supercedes_name"
    t.integer  "supercedes_build_number"
    t.boolean  "terminated",                  :default => false
    t.integer  "created_by"
    t.integer  "deployment_set"
    t.boolean  "default_after",               :default => true
  end

  create_table "sync_applications", :force => true do |t|
    t.string   "workflow_state"
    t.datetime "started_at"
    t.integer  "started_by"
    t.text     "exceptions"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.datetime "completed_at"
  end

  create_table "sync_jobs", :force => true do |t|
    t.text     "exceptions"
    t.datetime "started_at"
    t.integer  "started_by"
    t.datetime "completed_at"
    t.string   "workflow_state"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "type"
    t.integer  "environment_id"
    t.boolean  "in_retry"
  end

  create_table "system_configurations", :force => true do |t|
    t.string   "name"
    t.boolean  "in_effect"
    t.boolean  "deployments_future_schedulable"
    t.boolean  "switches_future_schedulable"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "debug_mode"
    t.boolean  "send_emails"
    t.integer  "num_latest_releases"
    t.boolean  "verify_switches"
    t.boolean  "show_latest_releases"
    t.integer  "disc_space_threshold"
    t.boolean  "check_disc_space_deployments"
    t.boolean  "show_latest_webapp"
    t.text     "latest_webapp"
    t.datetime "latest_webapp_at"
    t.boolean  "check_reo_for_deployments_approval"
    t.string   "deployment_kod"
    t.boolean  "allow_deployment_requests"
    t.boolean  "use_timer_service"
    t.boolean  "allow_auto_promotion"
    t.boolean  "enable_puppet_refresh_cron"
    t.integer  "puppet_refresh_batchsize"
    t.string   "puppet_refresh_cron_timings"
    t.boolean  "use_oos_for_deployments"
    t.text     "allow_delete_set"
  end

  create_table "useful_links", :force => true do |t|
    t.string   "name"
    t.boolean  "active"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "icon_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                     :default => "", :null => false
    t.string   "encrypted_password",        :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "username"
    t.string   "given_name"
    t.string   "svn_login"
    t.string   "svn_password"
    t.integer  "default_mail_recipient_id"
    t.string   "auth_key"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
