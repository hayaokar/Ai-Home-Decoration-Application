# Generated by Django 4.2.1 on 2023-05-17 19:53

from django.db import migrations, models
import shop.models


class Migration(migrations.Migration):

    dependencies = [
        ("shop", "0008_rename_customer_order_user"),
    ]

    operations = [
        migrations.RemoveField(
            model_name="product",
            name="image_file_name",
        ),
        migrations.AddField(
            model_name="product",
            name="image_url",
            field=models.ImageField(
                blank=True, null=True, upload_to=shop.models.upload_to
            ),
        ),
    ]