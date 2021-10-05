# README

This README would normally document whatever steps are necessary to get the
application up and running.

# SOFTWARE REQUIREMENTS

- Ruby version: ruby-3.0.2
- Rails Version: 6.1.4.1
- Database: sqlite 1.4

# CREDENTIALS
-username: admin
-password: admin

# APPLICATION URL

http://152.7.176.230:8080/

# Important Flow:
- admin credentials : admin/admin
- login as admin, create a leasing agent.
- Login as a leasing agent -> As a leasing agent we can create and delete a property.
- Can Also see the list of properties and list of properties
- An applicant can be signed up. -> create a applicant through the homepage.
- Login as an applicant -> see the list of properties
- Apply to one or more properties
- Log out as an applicant!
- Log in as an leasing agent -> see list of applications
- Accept / Reject an application as a leasing agent.
- If (accepted / CheckedIn), can checkout a tenant from a property by going inside the view of the specific property
- Login at homepage -> as applicant -> can see the properties and make an application to a properties.
- An Applicant can withdraw an application before getting accepted or rejected by a leasing agent.
- Waitlisting Feature is implemented.
- The waitlist feature is implicit, meaning that it is maintained as part of Application's Model and on checking out the Applicant successfully, all the applications to to the corresponding property will be moved to initiated status.
- If one of the application is accepted all the other applications go to waitlisted status.

# updates:

- Fixed Bugs from reviews
  1) Admin now can create/view/delete applicants.
  2) Admin can apply an application on behalf of a applicant.
  3) Added new validations in UI before form submission (NULL Checks and Negative Overflows)
  4) Removed apply application button for a leasing agent

