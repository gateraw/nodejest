
package com.termux.styling

import android.app.Activity
import android.app.AlertDialog
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.text.SpannableString
import android.text.method.LinkMovementMethod
import android.text.util.Linkify
import android.util.AtomicFile
import android.util.Log
import android.view.View
import android.view.WindowManager
import android.widget.ArrayAdapter
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import java.io.File
import java.io.FileOutputStream
import java.io.IOException
import java.nio.charset.StandardCharsets
import java.util.*

const val DEFAULT_FILENAME = "Default"

fun capitalize(str: String): String {
    var lastWhitespace = true
    val chars = str.toCharArray()
    for (i in chars.indices) {
        if (Character.isLetter(chars[i])) {
            if (lastWhitespace) chars[i] = Character.toUpperCase(chars[i])
            lastWhitespace = false
        } else {
            lastWhitespace = Character.isWhitespace(chars[i])
        }
    }
    return String(chars)
}

class TermuxStyleActivity : Activity() {

    internal class Selectable(val fileName: String) {
        val displayName: String

        init {
            var name = fileName.replace('-', ' ')
            val dotIndex = name.lastIndexOf('.')
            if (dotIndex != -1) name = name.substring(0, dotIndex)

            this.displayName = capitalize(name)
        }

        override fun toString(): String {
            return displayName
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
