/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: charmstr <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/17 16:14:41 by charmstr          #+#    #+#             */
/*   Updated: 2019/11/20 16:25:23 by charmstr         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "get_next_line.h"

/*
** note1: 	2nd set of conditions -> added feature:
**			if get_next_line() is called with NULL pointer it will remove/free
**			the potentially existing link matching the given filedescriptor.
**
** note2:	3rd set of conditions -> called only on the very frist time (static
**			pointer initialized to NULL).
**
** RETURN: -1 error occured
**			0 EOF is reached, and there is nothing left in "fd->rest" string
**			1 the END_LINE_CHAR was met and there is still things to be printed
**				out.
*/

int	get_next_line(int fd, char **line)
{
	static t_fd		*head;
	t_fd			*fd_link;
	int				result;

	if (fd < 0 || BUFFER_SIZE == 0)
		return (-1);
	if (!line)
		if (!manage_link(fd, &head, REMOVE))
			return (-1);
	if (!head)
		if (!(head = new_link(fd)))
			return (-1);
	if (!(fd_link = manage_link(fd, &head, ADD)))
		return (-1);
	fd_link->len_line = 0;
	result = to_read_or_not_to_read(fd_link, line);
	if (result <= 0)
		manage_link(fd, &head, REMOVE);
	return (result);
}

/*
** man:		should read until (an END_LINE_CHAR is reached and is not at the
**			end of the buffer) OR (EOF is reachedi). line is updated until the
**			first END_LINE_CHARR is met.
**
** note:	whatever followed the first END_LINE_CHAR is stored into fd->rest.
**
** RETURN:	-1	if a problem occured
**			0	if EOF reached and there is nothing left in link->rest string.
**			1	if there is more lines to be printed out.
*/

int	to_read_or_not_to_read(t_fd *link, char **line)
{
	int		bytes_read;
	char	buf[BUFFER_SIZE + 1];
	int		keep_going;

	keep_going = 1;
	if (link->len_rest)
		keep_going = update_strings(line, link->rest, link, 1);
	while (keep_going && !link->eof)
	{
		if ((bytes_read = read(link->fd, buf, BUFFER_SIZE)) == -1)
			return (-1);
		buf[bytes_read] = '\0';
		if (bytes_read < BUFFER_SIZE)
			link->eof = 1;
		if ((keep_going = update_strings(line, buf, link, keep_going)) == -1)
			return (-1);
		if ((bytes_read == BUFFER_SIZE) \
				&& (buf[bytes_read - 1] == END_LINE_CHAR))
			keep_going = 2;
	}
	if (link->eof && !link->len_rest)
		return (0);
	return (1);
}

/*
** man: 	concatenate anything found before an END_LINE_CHAR in parse_me
**			with the existing line. place the rest in fd_link->rest.
**
** note:	INPUTS for previous 1 or 2.
**			if 2: only rest is updated since we previously found an
**			END_LINE_CHAR and it RETURNS 0.
**
** RETURN:	-1 if a problem occured.
**			0 if a END_LINE_CHAR was found stop reading
**			1 if no END_LINE_CHAR was found
*/

int	update_strings(char **line, char *parse_me, t_fd *link, int previous)
{
	int start_rest;
	int found;
	int len;

	found = 0;
	start_rest = 0;
	if (previous == 1)
		if ((start_rest = update_line(line, parse_me, link, &found)) == -1)
			return (-1);
	if (parse_me[start_rest] == END_LINE_CHAR && previous == 1)
		start_rest++;
	if (previous == 2)
		len = update_rest(parse_me, link, start_rest, link->len_rest);
	else
		len = update_rest(parse_me, link, start_rest, 0);
	if (len == -1)
		return (-1);
	if (previous == 2)
		return (0);
	return (!found);
}

/*
** note:	this function will join the line and the given string until the end
**			of that string or until a END_LINE_CHAR is met.
**
** note:	fd_link->len_line is updated.
**
** RETURN:	index where the END_LINE_CHAR was met
**			or the size of the stringitself,
**			or -1 if a problem occured
*/

int	update_line(char **line, char *str2, t_fd *link, int *found)
{
	int		i;
	int		j;
	char	*tmp;

	tmp = *line;
	i = 0;
	j = -1;
	while (str2[i] && (str2[i] != END_LINE_CHAR))
		i++;
	if (str2[i] == END_LINE_CHAR)
		*found = 1;
	if (!(*line = (char*)malloc(sizeof(char) * (link->len_line + i + 1))))
		return (-1);
	(*line)[link->len_line + i] = '\0';
	while (++j < link->len_line + i)
	{
		if (j < link->len_line)
			(*line)[j] = tmp[j];
		else
			(*line)[j] = str2[j - link->len_line];
	}
	link->len_line = link->len_line + i;
	free(tmp);
	return (i);
}

/*
** note: 	will update the string link->rest with whatever was left after the
**			position where the END_LINE_CHAR was found. free old link->rest.
**
** RETURN:	0 if malloc failed
**			or the len of the added_rest
*/

int	update_rest(char *str, t_fd *link, int start, int old_len)
{
	int		i;
	char	*tmp;
	int		new_len;

	tmp = link->rest;
	new_len = 0;
	i = -1;
	while (str[start + new_len])
		new_len++;
	if (!(link->rest = (char*)malloc(sizeof(char) * (old_len + new_len + 1))))
		return (0);
	link->rest[old_len + new_len] = '\0';
	while (++i < old_len + new_len)
	{
		if (i < old_len)
			link->rest[i] = tmp[i];
		else
			link->rest[i] = str[start + (i - old_len)];
	}
	link->len_rest = new_len + old_len;
	free(tmp);
	return (1);
}
