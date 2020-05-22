<#macro login path isRegisterForm>
    <form action="${path}" method="post" class="form-login">
        <div class="form-group">
            <label for="inputLogin">User name</label>
            <input type="text" name="username" class="form-control validate ${(usernameError??)?string('invalid', '')}" value="<#if user??>${user.username}</#if>" id="inputLogin" />
            <span class="helper-text" data-error="${usernameError!}" data-success="right"></span>
        </div>
        <#if isRegisterForm>
            <div class="form-group">
                <label for="inputEmail">Email</label>
                <input id="inputEmail" type="email" name="email" value="<#if user??>${user.email}</#if>" class="form-control validate ${(emailError??)?string('invalid', '')}" />
                <span class="helper-text" data-error="${emailError!}" data-success="right"></span>
            </div>
        </#if>
        <div class="form-group">
            <label for="inputPassword">Password</label>
            <input type="password" name="password" class="form-control validate ${(passwordError??)?string('invalid', '')}" id="inputPassword" />
            <span class="helper-text" data-error="${passwordError!}" data-success="right"></span>
        </div>
        <#if isRegisterForm>
            <div class="form-group">
                <label for="inputPasswordConfirmation">Confirm Password</label>
                <input type="password" name="passwordConfirmation" class="form-control validate ${(passwordConfirmationError??)?string('invalid', '')}" id="inputPasswordConfirmation" />
                <span class="helper-text" data-error="${passwordConfirmationError!}" data-success="right"></span>
            </div>
            <input type="hidden" id="recaptcha_resp" name="g-recaptcha-response" value=""/>
        </#if>
        <input type="hidden" name="_csrf" value="${ _csrf.token}" />
        <button type="submit" class="waves-effect waves-light btn"><#if isRegisterForm>Sign Up<#else>Sing In</#if></button>
        <#if !isRegisterForm>
            <a class="waves-effect waves-light btn registration-redir" href="/registration">Sign Up</a>
        </#if>
        <#if isRegisterForm && captchaError??>
            <p class="error">${captchaError}</p>
        </#if>
    </form>
    <#if isRegisterForm>
        <script type="text/javascript">
            grecaptcha.ready(function() {
                grecaptcha.execute('6Lcw1fcUAAAAABOtyNQlyzCHKMhkoq4dmkcUrDTl', {action: 'homepage'}).then(function(token) {
                    console.log(token);
                    document.getElementById('recaptcha_resp').value = token;
                });
            });
        </script>
    </#if>
</#macro>