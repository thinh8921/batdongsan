package com.controller;

import java.io.IOException;
import java.nio.file.*;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.entities.*;
import com.service.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ProjectService projectService;

    @Autowired
    private DeveloperService developerService;

    @Autowired
    private UserService userService;

    private final String UPLOAD_DIR = "uploads/";

    // ===== Helper Methods =====
    private String saveUploadedFile(MultipartFile file, String subDir) throws IOException {
        if (file == null || file.isEmpty()) return null;
        String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
        Path path = Paths.get(UPLOAD_DIR + subDir);
        if (!Files.exists(path)) Files.createDirectories(path);
        Files.copy(file.getInputStream(), path.resolve(fileName), StandardCopyOption.REPLACE_EXISTING);
        return fileName;
    }

    private void setupProjectForm(Model model, Project project) {
        model.addAttribute("project", project);
        model.addAttribute("developers", developerService.findActiveDevelopers());
        model.addAttribute("projectTypes", ProjectType.values());
        model.addAttribute("projectStatuses", ProjectStatus.values());
        model.addAttribute("wards", new String[]{
            "Phường Tân Thuận Đông", "Phường Tân Thuận Tây", "Phường Tân Kiểng",
            "Phường Tân Hưng", "Phường Bình Thuận", "Phường Tân Phong",
            "Phường Tân Phú", "Phường Tân Quy", "Phường Phú Thuận", "Phường Phú Mỹ"
        });
    }

    // ===== Dashboard =====
    @GetMapping
    public String dashboard(Model model) {
        model.addAttribute("totalProjects", projectService.getTotalActiveProjects());
        model.addAttribute("apartmentCount", projectService.getProjectCountByType(ProjectType.APARTMENT));
        model.addAttribute("villaCount", projectService.getProjectCountByType(ProjectType.VILLA));
        model.addAttribute("officeCount", projectService.getProjectCountByType(ProjectType.OFFICE));
        model.addAttribute("totalUsers", userService.findAll().size());
        model.addAttribute("totalDevelopers", developerService.findAll().size());
        model.addAttribute("recentProjects", projectService.findAll().stream().limit(5).toList());
        return "admin/dashboard";
    }

    // ===== Project Management =====
    @GetMapping("/projects")
    public String listProjects(Model model) {
        model.addAttribute("projects", projectService.findAll());
        return "admin/projects/list";
    }

    @GetMapping({"/projects/create", "/projects/edit/{id}"})
    public String projectForm(@PathVariable(required = false) Integer id, Model model, RedirectAttributes redirect) {
        Project project = (id != null) ? projectService.findById(id).orElse(null) : new Project();
        if (id != null && project == null) {
            redirect.addFlashAttribute("error", "Dự án không tồn tại!");
            return "redirect:/admin/projects";
        }
        setupProjectForm(model, project);
        return "admin/projects/form";
    }

    @PostMapping({"/projects/create", "/projects/edit/{id}"})
    public String saveProject(@PathVariable(required = false) Integer id,
                              @Valid @ModelAttribute Project project,
                              BindingResult result,
                              @RequestParam(required = false) MultipartFile thumbnailFile,
                              RedirectAttributes redirect) {
        if (result.hasErrors()) {
            redirect.addFlashAttribute("error", "Dữ liệu không hợp lệ!");
            return (id != null) ? "redirect:/admin/projects/edit/" + id : "redirect:/admin/projects/create";
        }
        try {
            String fileName = saveUploadedFile(thumbnailFile, "projects");
            if (fileName != null) project.setThumbnail("/uploads/projects/" + fileName);

         // Không set ID, luôn tạo mới
            projectService.createProject(project);

            redirect.addFlashAttribute("success", "Lưu dự án thành công!");
        } catch (Exception e) {
            redirect.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/projects";
    }

    @PostMapping("/projects/delete/{id}")
    public String deleteProject(@PathVariable Integer id, RedirectAttributes redirect) {
        try {
            projectService.deleteProject(id);
            redirect.addFlashAttribute("success", "Xóa dự án thành công!");
        } catch (Exception e) {
            redirect.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/projects";
    }

    @PostMapping("/projects/toggle-status/{id}")
    public String toggleProjectStatus(@PathVariable Integer id, RedirectAttributes redirect) {
        projectService.findById(id).ifPresent(project -> {
            if (Boolean.TRUE.equals(project.getIsActive())) projectService.deactivateProject(id);
            else projectService.activateProject(id);
        });
        redirect.addFlashAttribute("success", "Đã thay đổi trạng thái dự án!");
        return "redirect:/admin/projects";
    }

    // ===== Developer Management =====
    @GetMapping("/developers")
    public String listDevelopers(Model model) {
        model.addAttribute("developers", developerService.findAll());
        return "admin/developers/list";
    }

    @GetMapping({"/developers/create", "/developers/edit/{id}"})
    public String developerForm(@PathVariable(required = false) Integer id, Model model, RedirectAttributes redirect) {
        Developer dev = (id != null) ? developerService.findById(id).orElse(null) : new Developer();
        if (id != null && dev == null) {
            redirect.addFlashAttribute("error", "Chủ đầu tư không tồn tại!");
            return "redirect:/admin/developers";
        }
        model.addAttribute("developer", dev);
        return "admin/developers/form";
    }

    @PostMapping({"/developers/create", "/developers/edit/{id}"})
    public String saveDeveloper(@PathVariable(required = false) Integer id,
                                @Valid @ModelAttribute Developer developer,
                                BindingResult result,
                                @RequestParam(required = false) MultipartFile logoFile,
                                RedirectAttributes redirect) {
        if (result.hasErrors()) {
            redirect.addFlashAttribute("error", "Dữ liệu không hợp lệ!");
            return (id != null) ? "redirect:/admin/developers/edit/" + id : "redirect:/admin/developers/create";
        }
        try {
            String fileName = saveUploadedFile(logoFile, "developers");
            if (fileName != null) developer.setLogoUrl("/uploads/developers/" + fileName);

            if (id != null) developer.setId(id);
            if (id != null) developerService.updateDeveloper(developer);
            else developerService.createDeveloper(developer);

            redirect.addFlashAttribute("success", "Lưu chủ đầu tư thành công!");
        } catch (Exception e) {
            redirect.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/developers";
    }

    @PostMapping("/developers/delete/{id}")
    public String deleteDeveloper(@PathVariable Integer id, RedirectAttributes redirect) {
        try {
            developerService.deleteDeveloper(id);
            redirect.addFlashAttribute("success", "Xóa chủ đầu tư thành công!");
        } catch (Exception e) {
            redirect.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/developers";
    }

    // ===== User Management =====
    @GetMapping("/users")
    public String listUsers(Model model) {
        model.addAttribute("users", userService.findAll());
        return "admin/users/list";
    }

    @GetMapping({"/users/create", "/users/edit/{id}"})
    public String userForm(@PathVariable(required = false) Integer id, Model model, RedirectAttributes redirect) {
        User user = (id != null) ? userService.findById(id).orElse(null) : new User();
        if (id != null && user == null) {
            redirect.addFlashAttribute("error", "Người dùng không tồn tại!");
            return "redirect:/admin/users";
        }
        model.addAttribute("user", user);
        model.addAttribute("userRoles", UserRole.values());
        return "admin/users/form";
    }

    @PostMapping({"/users/create", "/users/edit/{id}"})
    public String saveUser(@PathVariable(required = false) Integer id,
                           @Valid @ModelAttribute User user,
                           BindingResult result,
                           RedirectAttributes redirect) {
        if (result.hasErrors()) {
            redirect.addFlashAttribute("error", "Dữ liệu không hợp lệ!");
            return (id != null) ? "redirect:/admin/users/edit/" + id : "redirect:/admin/users/create";
        }
        try {
            if (id != null) user.setId(id);
            if (id != null) userService.updateUser(user);
            else userService.createUser(user);

            redirect.addFlashAttribute("success", "Lưu người dùng thành công!");
        } catch (Exception e) {
            redirect.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }

    @PostMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable Integer id, RedirectAttributes redirect) {
        try {
            userService.deleteUser(id);
            redirect.addFlashAttribute("success", "Xóa người dùng thành công!");
        } catch (Exception e) {
            redirect.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }
}
