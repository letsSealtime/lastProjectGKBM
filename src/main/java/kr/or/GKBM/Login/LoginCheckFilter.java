package kr.or.GKBM.Login;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginCheckFilter implements Filter {

    // 화이트리스트: 세션 검증 없이 허용할 경로
    private static final String[] WHITE_LIST = {
        "/login", "/logout", "/resources/", "/error"
    };

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        String requestURI = req.getRequestURI();

        // 화이트리스트 체크
        String contextPath = req.getContextPath();

        if (isWhiteList(requestURI, contextPath)) {
            chain.doFilter(request, response);
            return;
        }


        // 세션 체크
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // 미로그인 상태 → 로그인 페이지로 리다이렉트
            ((HttpServletResponse) response).sendRedirect(req.getContextPath() + "/login");
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean isWhiteList(String requestURI, String contextPath) {
        // contextPath가 ""이면 /login, 아니면 /GKBM/login 형태로 비교
        String loginPath = contextPath + "/login";
        String logoutPath = contextPath + "/logout";
        return requestURI.equals(loginPath)
            || requestURI.equals(logoutPath)
            || requestURI.startsWith(contextPath + "/resources/")
            || requestURI.equals(contextPath + "/error");
    }


    @Override
    public void init(FilterConfig filterConfig) {}

    @Override
    public void destroy() {}
}
