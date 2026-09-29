package com.medicinefinder.servlet;

import com.medicinefinder.dao.FeedbackDAO;
import com.medicinefinder.model.Feedback;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


public class FeedbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FeedbackDAO feedbackDAO = new FeedbackDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Feedback> feedbackList = feedbackDAO.getAllFeedback();
        request.setAttribute("feedbackList", feedbackList);
        request.getRequestDispatcher("/feedback.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String ratingStr = request.getParameter("rating");
        String comments = request.getParameter("comments");

        if (name == null || name.trim().isEmpty() ||
            ratingStr == null || comments == null || comments.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Name, Rating and Comments are required!");
            doGet(request, response);
            return;
        }

        int rating = 5;
        try {
            rating = Integer.parseInt(ratingStr);
        } catch (NumberFormatException ignored) {}

        Feedback fb = new Feedback();
        fb.setName(name.trim());
        fb.setEmail(email != null ? email.trim() : "anonymous@example.com");
        fb.setRating(rating);
        fb.setComments(comments.trim());

        boolean success = feedbackDAO.addFeedback(fb);

        if (success) {
            // Also append to XML feedback file for Exercise 8A
            appendToXml(fb, getServletContext().getRealPath("/xml/feedback.xml"));
            appendToXml5Input(fb, getServletContext().getRealPath("/xml/feedback-5input.xml"));

            request.setAttribute("userSubmittedName", fb.getName());
            request.setAttribute("userSubmittedEmail", fb.getEmail());
            request.setAttribute("successMessage", "Thank you for your feedback! Your response has been saved.");
            request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Failed to save feedback in database.");
            doGet(request, response);
        }
    }

    private void appendToXml(Feedback fb, String filePath) {
        try {
            File file = new File(filePath);
            if (!file.exists()) return;

            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(file);

            Element root = doc.getDocumentElement();

            Element feedbackElem = doc.createElement("feedback");

            Element nameElem = doc.createElement("name");
            nameElem.appendChild(doc.createTextNode(fb.getName()));
            feedbackElem.appendChild(nameElem);

            Element ratingElem = doc.createElement("rating");
            ratingElem.appendChild(doc.createTextNode(String.valueOf(fb.getRating())));
            feedbackElem.appendChild(ratingElem);

            Element commentsElem = doc.createElement("comments");
            commentsElem.appendChild(doc.createTextNode(fb.getComments()));
            feedbackElem.appendChild(commentsElem);

            root.appendChild(feedbackElem);

            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(file);
            transformer.transform(source, result);
        } catch (Exception e) {
            System.err.println("Could not append feedback to 3-input XML: " + e.getMessage());
        }
    }

    private void appendToXml5Input(Feedback fb, String filePath) {
        try {
            File file = new File(filePath);
            if (!file.exists()) return;

            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(file);

            Element root = doc.getDocumentElement();

            Element feedbackElem = doc.createElement("feedback");

            Element nameElem = doc.createElement("name");
            nameElem.appendChild(doc.createTextNode(fb.getName()));
            feedbackElem.appendChild(nameElem);

            Element emailElem = doc.createElement("email");
            emailElem.appendChild(doc.createTextNode(fb.getEmail()));
            feedbackElem.appendChild(emailElem);

            Element ratingElem = doc.createElement("rating");
            ratingElem.appendChild(doc.createTextNode(String.valueOf(fb.getRating())));
            feedbackElem.appendChild(ratingElem);

            Element commentsElem = doc.createElement("comments");
            commentsElem.appendChild(doc.createTextNode(fb.getComments()));
            feedbackElem.appendChild(commentsElem);

            Element dateElem = doc.createElement("date");
            String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
            dateElem.appendChild(doc.createTextNode(today));
            feedbackElem.appendChild(dateElem);

            root.appendChild(feedbackElem);

            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(file);
            transformer.transform(source, result);
        } catch (Exception e) {
            System.err.println("Could not append feedback to 5-input XML: " + e.getMessage());
        }
    }
}
