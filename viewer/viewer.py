import pygame
import os
import glob
pygame.init()

width = 400
height = 300
half_width = width/2
half_height = height/2

pygame.font.init()
myfont = pygame.font.SysFont("monospace",15, True)

screen = pygame.display.set_mode((800,600), pygame.FULLSCREEN)
surf = pygame.Surface((width,height))
done = False
#test_image = 'out/art/1.png'
test_image_file = max(glob.iglob('out/art/*.png'),key = os.path.getctime)
cur_image_file = test_image_file
image = pygame.image.load(test_image_file)

file_label = myfont.render(cur_image_file,
                             1, (255,255,255))


image_width = image.get_rect().size[0]
image_height = image.get_rect().size[1]
half_image_width = image_width/2
half_image_height= image_height/2


image_x = half_width - half_image_width
image_y = half_height - half_image_height


github_label = myfont.render("Github:",
                             1, (255,255,255))
github_label2 = myfont.render("https://github.com/Shalmezad/OpenEvoArt",
                             1, (200,200,255))

bg_image_file = 'viewer/bg.png'
bg_image = pygame.image.load(bg_image_file)


while not done:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            done = True
        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_ESCAPE or event.key == pygame.K_q:
                done = True
    test_image_file = max(glob.iglob('out/art/*.png'),key = os.path.getctime)
    if test_image_file != cur_image_file :
        cur_image_file = test_image_file
        pygame.time.wait(3000)
        image = pygame.image.load(cur_image_file)
        file_label = myfont.render(cur_image_file,
                             1, (255,255,255))

    # Background:
    surf.blit(bg_image,(0,0))

    # Github info
    surf.blit(github_label,(10,10))
    surf.blit(github_label2,(10,24))
    # File label
    surf.blit(file_label, (10, height-20))

    # Border:
    pygame.draw.rect(surf,(255,255,255),
                     pygame.Rect(image_x-2,
                                 image_y-2,
                                 image_width+4,
                                 image_height+4))
    pygame.draw.rect(surf,(0,0,0),
                     pygame.Rect(image_x-1,
                                 image_y-1,
                                 image_width+2,
                                 image_height+2))
    # Image
    surf.blit(image, (image_x, image_y))
    screen.blit(pygame.transform.scale(surf,(800,600)), (0,0))
    #screen.blit(surf,(0,0))
    pygame.display.flip()
pygame.quit()
