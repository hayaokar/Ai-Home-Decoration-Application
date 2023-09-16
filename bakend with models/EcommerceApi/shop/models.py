from django.db import models
from django.contrib.auth.models import User
from django.dispatch import receiver
from django.db.models.signals import post_save
# Create your models here.

def upload_to(instance, filename):
    return 'images/{filename}'.format(filename=filename)


class Category(models.Model):
    name = models.CharField(max_length=50)
    description = models.TextField(null=True)
    image_url = models.ImageField(upload_to=upload_to, blank=True, null=True)
    class Meta:
        verbose_name_plural = "Categories"

    def __str__(self):
        return self.name
    def get_category_products(self):
        return Product.objects.filter(category__name=self.name)


class Product(models.Model):
    name = models.CharField(max_length=50)
    description = models.TextField(null=True)
    price = models.IntegerField()
    image_url = models.ImageField(upload_to=upload_to, blank=True, null=True)
    category = models.ForeignKey(Category,on_delete=models.CASCADE,related_name='products')
    def __str__(self):
        return self.name



class Order(models.Model):
    user = models.ForeignKey('auth.user', related_name='orders', on_delete=models.CASCADE,null=True)
    
    date = models.DateField(auto_now=True)
    orderItems = models.ManyToManyField(Product, through="OrderItems")
    total_price = models.IntegerField(null=True,blank=True)

    def __str__(self):
        return str(self.id) 
        
    

class OrderItems(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE,)
    item = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField(default=1)

   
    def __str__(self):
        return str(self.item) 

class Cart(models.Model):
    user = models.OneToOneField(User, related_name="user_cart", on_delete=models.CASCADE ,null=True)
    date = models.DateField(auto_now=True)
    total_price = models.DecimalField(max_digits=10, decimal_places=2,null=True,blank=True)
    @property
    def cart_total(self):
        cartitems = self.cartitems_set.all()
        total = sum([ item.subTotal for item in cartitems])
        return total
    
    def __str__(self):
       return self.user.username
    
@receiver(post_save, sender=User)
def create_user_cart(sender, created, instance, *args, **kwargs):
    if created:
        Cart.objects.create(user=instance)

class CartItems(models.Model):
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE)
    item = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField(default=1)

    @property
    def subTotal(self):
        total = self.quantity * self.item.price
        
        return total



    

    