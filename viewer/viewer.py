import pygame
pygame.init()

width = 400
height = 300
half_width = width/2
half_height = height/2

image_width = 144
image_height = 90
half_image_width = image_width/2
half_image_height= image_height/2

screen = pygame.display.set_mode((width,height))
done = False
test_image = 'out/art/1.png'
image = pygame.image.load(test_image)

image_x = half_width - half_image_width
image_y = half_height - half_image_height

pygame.font.init()
myfont = pygame.font.SysFont("monospace",15, True)

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
    # Background:
    #pygame.draw.rect(screen,(20,50,20), pygame.Rect(0,0,width,height))
    screen.blit(bg_image,(0,0))

    # Github info
    screen.blit(github_label,(10,10))
    screen.blit(github_label2,(10,24))

    # Border:
    pygame.draw.rect(screen,(255,255,255),
                     pygame.Rect(image_x-2,
                                 image_y-2,
                                 image_width+4,
                                 image_height+4))
    pygame.draw.rect(screen,(0,0,0),
                     pygame.Rect(image_x-1,
                                 image_y-1,
                                 image_width+2,
                                 image_height+2))
    # Image
    screen.blit(image, (image_x, image_y))
    pygame.display.flip()
