using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using BSIA.Models;
using BSIA.Account;

namespace BSIA
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                //If authenticated, hide panel and error messages, show success text.
                d_LoginMessageSuccess.Visible = true;
                d_ErrorMessage.Visible = false;
                d_SuccessText.Text = "<span style='font-weight: bold; font-size: 14pt;'>Login Success!<br /> Welcome, " + User.Identity.GetUserName() + "</span>";
                d_pnl_login.Visible = false;
            }
        }

        protected void d_LogIn(object sender, EventArgs e)
        {
            if (IsValid)
            {
                // Validate the user password
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                var signinManager = Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();

                // This doen't count login failures towards account lockout
                // To enable password failures to trigger lockout, change to shouldLockout: true
                var result = signinManager.PasswordSignIn(d_UserName.Text, d_Password.Text, d_RememberMe.Checked, shouldLockout: false);

                switch (result)
                {
                    case SignInStatus.Success:
                        IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                        break;
                    case SignInStatus.LockedOut:
                        Response.Redirect("/Account/Lockout");
                        break;
                    case SignInStatus.RequiresVerification:
                        Response.Redirect(String.Format("/Account/TwoFactorAuthenticationSignIn?ReturnUrl={0}&RememberMe={1}",
                                                        Request.QueryString["ReturnUrl"],
                                                        d_RememberMe.Checked),
                                          true);
                        break;
                    case SignInStatus.Failure:
                    default:
                        d_FailureText.Text = "Invalid login attempt";
                        d_ErrorMessage.Visible = true;
                        break;
                }
            }
        }
    }
}