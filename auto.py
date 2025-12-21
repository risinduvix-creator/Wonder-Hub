import discord
from discord.ext import commands, tasks
import os
import asyncio
import random
import sys
import json
from colorama import init, Fore

init(autoreset=True)

# --- Obfuscated Token Loading ---
def load_token():
    # 1. Checks Railway/System Environment Variables first (Most Secure)
    token = os.getenv("TOKEN")
    if token:
        return token
    
    # 2. Fallback to token.json if running locally
    try:
        with open("token.json", "r") as file:
            return json.load(file).get("TOKEN")
    except Exception:
        return None

bot = commands.Bot(command_prefix="!", self_bot=True)

# Global status flags
is_raiding = False
grinder_active = False
current_app_id = None
current_status_text = "Idle"

# --- Tasks & Logic ---
async def countdown_display(seconds):
    for i in range(seconds, 0, -1):
        if not grinder_active: break
        mins, secs = divmod(i, 60)
        sys.stdout.write(f"\r{Fore.CYAN}🤖 Next Grind: {mins:02d}:{secs:02d} ...   ")
        sys.stdout.flush()
        await asyncio.sleep(1)

@tasks.loop(seconds=1)
async def economy_grinder():
    global grinder_active
    if not grinder_active or not hasattr(bot, 'grind_channel'): return
    try:
        await bot.grind_channel.send("?work")
        await bot.grind_channel.send("?dep all")
    except Exception as e:
        print(Fore.RED + f"Grinder error: {e}")
    await countdown_display(180) # Exactly 3 mins

# --- Commands ---
@bot.event
async def on_ready():
    print(Fore.MAGENTA + f"✅ Logged in as: {bot.user}")

@bot.command()
async def grind(ctx):
    global grinder_active
    await ctx.message.delete()
    if not grinder_active:
        grinder_active = True
        bot.grind_channel = ctx.channel
        if not economy_grinder.is_running(): economy_grinder.start()
        print(Fore.GREEN + "💰 Grinder: ON")
    else:
        grinder_active = False
        economy_grinder.stop()
        print(Fore.RED + "💰 Grinder: OFF")

@bot.command()
async def setstatus(ctx, app_id: int, *, text: str):
    await ctx.message.delete()
    activity = discord.Activity(type=discord.ActivityType.playing, application_id=app_id, name=text)
    await bot.change_presence(activity=activity)
    print(Fore.GREEN + f"✅ Status: {text}")

@bot.command()
async def raid(ctx, count: int, delay: float, *, message: str):
    global is_raiding
    await ctx.message.delete()
    is_raiding = True
    for i in range(count):
        if not is_raiding: break
        await ctx.send(message)
        await asyncio.sleep(delay)
    is_raiding = False

# --- 24/7 Start Engine ---
if __name__ == "__main__":
    USER_TOKEN = load_token()
    if USER_TOKEN:
        while True:
            try:
                bot.run(USER_TOKEN)
            except Exception as e:
                print(Fore.RED + f"Connection lost: {e}. Restarting...")
                import time
                time.sleep(10)
    else:
        print(Fore.RED + "FATAL: No Token found in Variables or JSON!")
