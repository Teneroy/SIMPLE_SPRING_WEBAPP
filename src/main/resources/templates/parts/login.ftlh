<#macro login path>
    <form action="${path}" method="post" class="form-login">
        <div class="form-group">
            <label for="inputLogin">User name</label>
            <input type="text" name="username" class="form-control" id="inputLogin">
        </div>
        <div class="form-group">
            <label for="inputPassword">Password</label>
            <input type="password" name="password" class="form-control" id="inputPassword">
        </div>
        <input type="hidden" name="_csrf" value="${ _csrf.token}" />
        <button type="submit" class="waves-effect waves-light btn">Sign In</button>
        <a class="waves-effect waves-light btn registration-redir" href="/registration">Sign Up</a>
    </form>
</#macro>