package com.proqik.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class PortfolioServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "/uploads/portfolio/";
    private static final List<String> SAMPLE_PORTFOLIO = new ArrayList<>();

    static {
        SAMPLE_PORTFOLIO.add("sample1.jpg");
        SAMPLE_PORTFOLIO.add("sample2.jpg");
        SAMPLE_PORTFOLIO.add("sample3.jpg");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String email = (String) session.getAttribute("user");
        List<String> userPortfolio = getUserPortfolio(email);

        req.setAttribute("portfolio", userPortfolio);
        req.getRequestDispatcher("/WEB-INF/views/dashboard/vendor.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");

        if ("upload".equals(action)) {
            handleUpload(req, res);
        } else if ("delete".equals(action)) {
            handleDelete(req, res);
        } else {
            res.sendRedirect(req.getContextPath() + "/dashboard");
        }
    }

    private void handleUpload(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("user");

        String fileName = req.getParameter("fileName");
        if (fileName != null && !fileName.isEmpty()) {
            addToUserPortfolio(email, fileName);
        }

        res.sendRedirect(req.getContextPath() + "/dashboard");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("user");

        String fileName = req.getParameter("fileName");
        if (fileName != null) {
            removeFromUserPortfolio(email, fileName);
        }

        res.sendRedirect(req.getContextPath() + "/dashboard");
    }

    private List<String> getUserPortfolio(String email) {
        return new ArrayList<>(SAMPLE_PORTFOLIO);
    }

    private void addToUserPortfolio(String email, String fileName) {
        if (!SAMPLE_PORTFOLIO.contains(fileName)) {
            SAMPLE_PORTFOLIO.add(fileName);
        }
    }

    private void removeFromUserPortfolio(String email, String fileName) {
        SAMPLE_PORTFOLIO.remove(fileName);
    }
}