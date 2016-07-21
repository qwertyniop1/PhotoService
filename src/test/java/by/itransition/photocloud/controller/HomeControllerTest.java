package by.itransition.photocloud.controller;

import org.junit.Test;

import static org.junit.Assert.*;

public class HomeControllerTest {

    @Test
    public void index() throws Exception {
        HomeController controller = new HomeController();
        assertEquals("index", controller.index());
    }

}